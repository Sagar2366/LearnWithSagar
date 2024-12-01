```
import json
from datetime import datetime, timedelta

# Load the JSON file
with open("buckets.json", "r") as file:
    data = json.load(file)

# Cost per GB in various storage classes
COST_STANDARD = 0.023
COST_GLACIER = 0.004

# Function to calculate days since the bucket was last accessed
def days_since_last_access(last_access_date):
    last_access = datetime.strptime(last_access_date, "%Y-%m-%d")
    return (datetime.now() - last_access).days

# Task 1: Summary Report
print("=== Bucket Summary Report ===")
for bucket in data["buckets"]:
    print(f"Name: {bucket['name']}, Region: {bucket['region']}, Size: {bucket['sizeGB']} GB, Versioning: {bucket['versioning']}")

# Task 2 & 3: Identify Unused Buckets and Generate Cost Report
print("\n=== Cost Report ===")
region_cost = {}
team_cost = {}
deletion_queue = []
archival_candidates = []

for bucket in data["buckets"]:
    size = bucket["sizeGB"]
    region = bucket["region"]
    team = bucket["tags"]["team"]
    last_accessed_date = bucket.get("lastAccessed", bucket["createdOn"])  # Default to createdOn if lastAccessed missing

    # Update region and team cost
    region_cost[region] = region_cost.get(region, 0) + size * COST_STANDARD
    team_cost[team] = team_cost.get(team, 0) + size * COST_STANDARD

    # Check for unused buckets larger than 80GB
    if size > 80 and days_since_last_access(last_accessed_date) > 90:
        print(f"Unused Bucket (>80GB): {bucket['name']} in {region} not accessed in 90+ days.")

    # Add to deletion queue or archival list based on conditions
    if size > 100 and days_since_last_access(last_accessed_date) > 20:
        deletion_queue.append(bucket["name"])
    elif days_since_last_access(last_accessed_date) > 90:
        archival_candidates.append(bucket["name"])

# Print cost breakdown by region and team
print("\n--- Cost by Region ---")
for region, cost in region_cost.items():
    print(f"Region: {region}, Total Cost: ${cost:.2f}")

print("\n--- Cost by Team ---")
for team, cost in team_cost.items():
    print(f"Team: {team}, Total Cost: ${cost:.2f}")

# Task 4: Final List of Actions
print("\n=== Final Actions ===")
print("Buckets to Delete:")
for bucket_name in deletion_queue:
    print(f"- {bucket_name}")

print("\nBuckets to Archive:")
for bucket_name in archival_candidates:
    print(f"- {bucket_name}")
```
