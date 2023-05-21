import pandas as pd

def generate_report(output_location_root):
    # Load customers data
    customers_data = pd.read_csv(f'{output_location_root}/customers.csv')

    # Load transactions data
    transactions_data = pd.DataFrame()
    transactions_dir = f'{output_location_root}/transactions/'
    for root, dirs, files in os.walk(transactions_dir):
        for file in files:
            if file.endswith('.json'):
                file_path = os.path.join(root, file)
                df = pd.read_json(file_path, lines=True)
                transactions_data = transactions_data.append(df, ignore_index=True)

    # Merge customers and transactions data
    report_data = pd.merge(transactions_data, customers_data, on='customer_id')

    # Perform analysis
    report_summary = report_data.groupby('product_category').agg({
        'price': ['count', 'mean', 'sum'],
        'loyalty_score': 'mean'
    })

    # Print report summary
    print("=== Report Summary ===")
    print(report_summary)

    # Generate visualization (example: bar plot of transaction count by category)
    transaction_counts = report_summary[('price', 'count')]
    transaction_counts.plot(kind='bar', title='Transaction Count by Category')
    plt.xlabel('Product Category')
    plt.ylabel('Transaction Count')
    plt.show()