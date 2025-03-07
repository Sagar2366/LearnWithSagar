import json
from datetime import datetime
from typing import Dict, List, Tuple

# Constants
COST_STANDARD = 0.023  # Standard storage cost per GB
COST_GLACIER = 0.004   # Glacier storage cost per GB

# Load JSON data
def load_buckets(file_path: str) -> Dict:
    """Load bucket data from a JSON file."""
    with open(file_path, "r") as file:
        return json.load(file)

# Calculate days since last access
def days_since_last_access(last_access_date: str) -> int:
    """Calculate the number of days since the last access date."""
    last_access = datetime.strptime(last_access_date, "%Y-%m-%d")
    return (datetime.now() - last_access).days

# Calculate storage cost
def calculate_cost(size_gb: float, storage_class: str = "standard") -> float:
    """Calculate the storage cost based on size and storage class."""
    cost_per_gb = COST_GLACIER if storage_class == "glacier" else COST_STANDARD
    return size_gb * cost_per_gb

# Generate bucket summary
def generate_bucket_summary(buckets: List[Dict]) -> None:
    """Print a summary of each bucket."""
    print("=== Bucket Summary Report ===")
    for bucket in buckets:
        print(f"Name: {bucket['name']}, Region: {bucket['region']}, Size: {bucket['sizeGB']} GB, Versioning: {bucket['versioning']}")

# Generate cost report
def generate_cost_report(buckets: List[Dict]) -> Tuple[Dict, Dict]:
    """Generate a cost report by region and team."""
    region_cost = {}
    team_cost = {}

    for bucket in buckets:
        size = bucket["sizeGB"]
        region = bucket["region"]
        team = bucket["tags"]["team"]

        # Update region and team costs
        region_cost[region] = region_cost.get(region, 0) + calculate_cost(size)
        team_cost[team] = team_cost.get(team, 0) + calculate_cost(size)

    return region_cost, team_cost

# Identify unused buckets
def identify_unused_buckets(buckets: List[Dict], size_threshold: int = 80, days_threshold: int = 90) -> None:
    """Identify and print unused buckets based on size and days since last access."""
    print("\n=== Unused Buckets ===")
    for bucket in buckets:
        size = bucket["sizeGB"]
        last_accessed_date = bucket.get("lastAccessed", bucket["createdOn"])
        if size > size_threshold and days_since_last_access(last_accessed_date) > days_threshold:
            print(f"Unused Bucket (> {size_threshold}GB): {bucket['name']} in {bucket['region']} not accessed in {days_threshold}+ days.")

# Identify buckets for deletion and archival
def identify_buckets_for_actions(buckets: List[Dict]) -> Tuple[List[str], List[str]]:
    """Identify buckets for deletion and archival."""
    deletion_queue = []
    archival_candidates = []

    for bucket in buckets:
        size = bucket["sizeGB"]
        last_accessed_date = bucket.get("lastAccessed", bucket["createdOn"])

        # Add to deletion queue if size > 100 GB and unused for 20+ days
        if size > 100 and days_since_last_access(last_accessed_date) > 20:
            deletion_queue.append(bucket["name"])
        # Add to archival candidates if unused for 90+ days
        elif days_since_last_access(last_accessed_date) > 90:
            archival_candidates.append(bucket["name"])

    return deletion_queue, archival_candidates

# Calculate potential savings by moving to Glacier
def calculate_potential_savings(buckets: List[Dict], archival_candidates: List[str]) -> float:
    """Calculate potential savings by moving archival candidates to Glacier."""
    total_savings = 0.0
    print("\n=== Potential Savings by Moving to Glacier ===")
    for bucket in buckets:
        if bucket["name"] in archival_candidates:
            size = bucket["sizeGB"]
            savings = calculate_cost(size) - calculate_cost(size, "glacier")
            total_savings += savings
            print(f"Bucket: {bucket['name']}, Potential Savings: ${savings:.2f}")
    return total_savings

# Main function
def main():
    # Load bucket data
    buckets = load_buckets("buckets.json")["buckets"]

    # Task 1: Generate bucket summary
    generate_bucket_summary(buckets)

    # Task 2 & 3: Generate cost report and identify unused buckets
    region_cost, team_cost = generate_cost_report(buckets)
    print("\n=== Cost Report ===")
    print("--- Cost by Region ---")
    for region, cost in region_cost.items():
        print(f"Region: {region}, Total Cost: ${cost:.2f}")
    print("\n--- Cost by Team ---")
    for team, cost in team_cost.items():
        print(f"Team: {team}, Total Cost: ${cost:.2f}")

    identify_unused_buckets(buckets)

    # Task 4: Identify buckets for deletion and archival
    deletion_queue, archival_candidates = identify_buckets_for_actions(buckets)
    print("\n=== Final Actions ===")
    print("Buckets to Delete:")
    for bucket_name in deletion_queue:
        print(f"- {bucket_name}")
    print("\nBuckets to Archive:")
    for bucket_name in archival_candidates:
        print(f"- {bucket_name}")

    # Calculate potential savings
    total_savings = calculate_potential_savings(buckets, archival_candidates)
    print(f"\nTotal Potential Savings: ${total_savings:.2f}")

if __name__ == "__main__":
    main()