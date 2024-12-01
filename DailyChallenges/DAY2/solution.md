```
import json
from datetime import datetime, timedelta

# Constants
COST_PER_GB = 0.023  # Cost per GB for S3 Standard
GLACIER_COST_PER_GB = 0.004  # Cost per GB for Glacier
DAYS_UNUSED_THRESHOLD = 90
DAYS_INACTIVE_THRESHOLD = 20



def load_json_file(filepath):
    """Load JSON data from a file."""
    try:
        with open(filepath, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        print(f"Error: File {filepath} not found.")
        exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Failed to parse JSON file {filepath}. Details: {e}")
        exit(1)

# Helper function to calculate days since creation
def days_since_creation(date_string):
    created_on = datetime.strptime(date_string, "%Y-%m-%d")
    return (datetime.now() - created_on).days

# 1. Summary of each bucket
def print_summary(buckets):
    print("Bucket Summary:")
    print("=" * 50)
    for bucket in buckets:
        print(f"Name: {bucket['name']}, Region: {bucket['region']}, Size: {bucket['sizeGB']} GB, Versioning: {bucket['versioning']}")
    print("=" * 50)

# 2. Identify buckets larger than 80 GB and unused for 90+ days
def identify_large_unused_buckets(buckets):
    large_unused = []
    for bucket in buckets:
        if bucket["sizeGB"] > 80 and days_since_creation(bucket["createdOn"]) > DAYS_UNUSED_THRESHOLD:
            large_unused.append(bucket)
    return large_unused

# 3. Generate cost report grouped by region and department
def generate_cost_report(buckets):
    region_costs = {}
    deletion_queue = []
    glacier_candidates = []

    for bucket in buckets:
        # Group costs by region and department
        region = bucket["region"]
        department = bucket["tags"]["team"]
        size = bucket["sizeGB"]
        cost = size * COST_PER_GB

        if region not in region_costs:
            region_costs[region] = {}
        if department not in region_costs[region]:
            region_costs[region][department] = 0
        region_costs[region][department] += cost

        # Recommendations based on size and age
        days_unused = days_since_creation(bucket["createdOn"])
        if size > 100 and days_unused > DAYS_INACTIVE_THRESHOLD:
            deletion_queue.append(bucket)
        elif size > 50:
            glacier_candidates.append(bucket)

    return region_costs, deletion_queue, glacier_candidates

# 4. Final list of buckets to delete and archive
def generate_final_recommendations(deletion_queue, glacier_candidates):
    print("\nBuckets Recommended for Deletion:")
    print("=" * 50)
    for bucket in deletion_queue:
        print(f"Name: {bucket['name']}, Size: {bucket['sizeGB']} GB, Last Accessed: {bucket['createdOn']}")

    print("\nBuckets Recommended for Glacier Archival:")
    print("=" * 50)
    for bucket in glacier_candidates:
        if bucket not in deletion_queue:  # Exclude those already in deletion queue
            print(f"Name: {bucket['name']}, Size: {bucket['sizeGB']} GB, Last Accessed: {bucket['createdOn']}")

# Main Execution
"""Main entry point for the script."""
filepath = "buckets.json"  # Path to your JSON file
data = load_json_file(filepath)
buckets = data["buckets"]


# Step 1: Print summary of all buckets
print_summary(buckets)

# Step 2: Identify buckets larger than 80 GB unused for 90+ days
large_unused_buckets = identify_large_unused_buckets(buckets)
print("\nLarge Buckets Unused for 90+ Days:")
for bucket in large_unused_buckets:
    print(f"Name: {bucket['name']}, Size: {bucket['sizeGB']} GB, Created On: {bucket['createdOn']}")

# Step 3: Generate cost report
region_costs, deletion_queue, glacier_candidates = generate_cost_report(buckets)
print("\nCost Report by Region and Department:")
for region, departments in region_costs.items():
    print(f"Region: {region}")
    for department, total_cost in departments.items():
        print(f"  Department: {department}, Total Cost: ${total_cost:.2f}")

# Step 4: Final Recommendations
generate_final_recommendations(deletion_queue, glacier_candidates)
```
