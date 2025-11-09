"""
Script to train and save the KNN model for customer churn prediction.
This generates a sample telecom churn dataset and trains the model.
"""
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import LabelEncoder
import joblib
import os

def generate_sample_data(n_samples=1000):
    """Generate a sample telecom churn dataset."""
    np.random.seed(42)
    
    data = {
        'customerID': [f'CUST{i:05d}' for i in range(1, n_samples + 1)],
        'gender': np.random.choice(['Male', 'Female'], n_samples),
        'SeniorCitizen': np.random.choice([0, 1], n_samples, p=[0.84, 0.16]),
        'Partner': np.random.choice(['Yes', 'No'], n_samples),
        'Dependents': np.random.choice(['Yes', 'No'], n_samples),
        'tenure': np.random.randint(1, 73, n_samples),
        'PhoneService': np.random.choice(['Yes', 'No'], n_samples, p=[0.9, 0.1]),
        'MultipleLines': np.random.choice(['Yes', 'No', 'No phone service'], n_samples, p=[0.42, 0.48, 0.1]),
        'InternetService': np.random.choice(['DSL', 'Fiber optic', 'No'], n_samples, p=[0.35, 0.44, 0.21]),
        'OnlineSecurity': np.random.choice(['Yes', 'No', 'No internet service'], n_samples, p=[0.29, 0.5, 0.21]),
        'OnlineBackup': np.random.choice(['Yes', 'No', 'No internet service'], n_samples, p=[0.35, 0.44, 0.21]),
        'DeviceProtection': np.random.choice(['Yes', 'No', 'No internet service'], n_samples, p=[0.34, 0.45, 0.21]),
        'TechSupport': np.random.choice(['Yes', 'No', 'No internet service'], n_samples, p=[0.29, 0.5, 0.21]),
        'StreamingTV': np.random.choice(['Yes', 'No', 'No internet service'], n_samples, p=[0.38, 0.41, 0.21]),
        'StreamingMovies': np.random.choice(['Yes', 'No', 'No internet service'], n_samples, p=[0.39, 0.4, 0.21]),
        'Contract': np.random.choice(['Month-to-month', 'One year', 'Two year'], n_samples, p=[0.55, 0.21, 0.24]),
        'PaperlessBilling': np.random.choice(['Yes', 'No'], n_samples),
        'PaymentMethod': np.random.choice(['Electronic check', 'Mailed check', 'Bank transfer (automatic)', 'Credit card (automatic)'], n_samples),
        'MonthlyCharges': np.round(np.random.uniform(18.25, 118.75, n_samples), 2),
        'TotalCharges': np.round(np.random.uniform(18.8, 8684.8, n_samples), 2)
    }
    
    df = pd.DataFrame(data)
    
    # Generate churn based on some logic (higher churn for certain conditions)
    churn_probs = []
    for idx, row in df.iterrows():
        prob = 0.1  # base probability
        if row['Contract'] == 'Month-to-month':
            prob += 0.3
        if row['InternetService'] == 'Fiber optic':
            prob += 0.15
        if row['PaymentMethod'] == 'Electronic check':
            prob += 0.2
        if row['tenure'] < 12:
            prob += 0.2
        if row['MonthlyCharges'] > 70:
            prob += 0.1
        if row['SeniorCitizen'] == 1:
            prob += 0.1
        prob = min(prob, 0.95)
        churn_probs.append(prob)
    
    df['Churn'] = np.random.binomial(1, churn_probs)
    df['Churn'] = df['Churn'].map({0: 'No', 1: 'Yes'})
    
    return df

def prepare_features(df):
    """Prepare features for model training."""
    # Select features for training
    feature_cols = [
        'gender', 'SeniorCitizen', 'Partner', 'Dependents', 'tenure',
        'PhoneService', 'MultipleLines', 'InternetService', 'OnlineSecurity',
        'OnlineBackup', 'DeviceProtection', 'TechSupport', 'StreamingTV',
        'StreamingMovies', 'Contract', 'PaperlessBilling', 'PaymentMethod',
        'MonthlyCharges', 'TotalCharges'
    ]
    
    X = df[feature_cols].copy()
    y = df['Churn'].copy()
    
    # Encode categorical variables
    label_encoders = {}
    categorical_cols = X.select_dtypes(include=['object']).columns
    
    for col in categorical_cols:
        le = LabelEncoder()
        X[col] = le.fit_transform(X[col])
        label_encoders[col] = le
    
    return X, y, label_encoders, feature_cols

def train_model():
    """Train the KNN model and save it."""
    print("Generating sample dataset...")
    df = generate_sample_data(2000)
    
    print("Preparing features...")
    X, y, label_encoders, feature_cols = prepare_features(df)
    
    # Encode target variable
    target_encoder = LabelEncoder()
    y_encoded = target_encoder.fit_transform(y)
    
    # Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y_encoded, test_size=0.2, random_state=42, stratify=y_encoded
    )
    
    # Train KNN model
    print("Training KNN model...")
    knn = KNeighborsClassifier(n_neighbors=15, weights='distance')
    knn.fit(X_train, y_train)
    
    # Calculate accuracy
    accuracy = knn.score(X_test, y_test)
    print(f"Model accuracy: {accuracy:.4f}")
    
    # Save model and encoders
    os.makedirs('models', exist_ok=True)
    joblib.dump(knn, 'models/knn_model.pkl')
    joblib.dump(label_encoders, 'models/label_encoders.pkl')
    joblib.dump(target_encoder, 'models/target_encoder.pkl')
    joblib.dump(feature_cols, 'models/feature_cols.pkl')
    
    # Save sample dataset for reference
    df.to_csv('data/sample_churn_data.csv', index=False)
    print("Model and encoders saved successfully!")
    print("Sample dataset saved to data/sample_churn_data.csv")
    
    return knn, label_encoders, target_encoder, feature_cols

if __name__ == '__main__':
    # Ensure we're in the correct directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)
    
    # Create necessary directories
    os.makedirs('data', exist_ok=True)
    os.makedirs('models', exist_ok=True)
    
    train_model()

