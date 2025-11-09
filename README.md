# Customer Churn Prediction Website

A modern web application for predicting customer churn using Machine Learning. Built with Flask (Python) and featuring a trained K-Nearest Neighbors (KNN) classifier.

## Features

- 🤖 **ML-Powered Predictions**: KNN model trained on telecom customer data
- 📊 **Batch Processing**: Upload CSV files for multiple predictions
- 📈 **Analytics Dashboard**: Visualize churn statistics with interactive charts
- 💾 **Prediction History**: SQLite database to track all predictions
- 🎨 **Modern UI**: Beautiful, responsive design with smooth animations
- 📱 **Mobile Friendly**: Works seamlessly on all devices

## Technology Stack

- **Backend**: Flask (Python)
- **ML Model**: Scikit-learn (KNeighborsClassifier)
- **Database**: SQLite
- **Frontend**: HTML5, CSS3, JavaScript
- **Visualization**: Chart.js
- **Icons**: Font Awesome

## Installation

### Prerequisites

- Python 3.8 or higher
- pip (Python package manager)

### Setup Steps

1. **Clone or download this repository**

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Train the ML model**
   ```bash
   python train_model.py
   ```
   This will:
   - Generate a sample telecom churn dataset
   - Train the KNN model
   - Save the model and encoders to the `models/` directory
   - Create a sample dataset CSV in the `data/` directory

4. **Run the Flask application**
   ```bash
   python app.py
   ```

5. **Open your browser**
   Navigate to `http://localhost:8000`

## Project Structure

```
customer/
├── app.py                 # Flask application
├── train_model.py         # Model training script
├── requirements.txt       # Python dependencies
├── templates/            # HTML templates
│   ├── base.html
│   ├── index.html
│   ├── predict.html
│   ├── upload.html
│   ├── dashboard.html
│   ├── about.html
│   └── contact.html
├── static/
│   ├── css/
│   │   └── style.css     # Main stylesheet
│   ├── js/
│   │   └── main.js       # JavaScript functionality
│   └── images/
│       └── churn-hero.svg
├── models/               # Trained models (created after training)
├── data/                 # Sample datasets (created after training)
├── uploads/              # Uploaded CSV files
└── churn_predictions.db  # SQLite database (created on first run)
```

## Usage

### Making Predictions

#### Option 1: Manual Input
1. Navigate to the "Predict" page
2. Fill in all customer details in the form
3. Click "Predict Churn"
4. View the prediction result with confidence score

#### Option 2: CSV Upload
1. Navigate to the "Upload CSV" page
2. Prepare a CSV file with customer data (see format guide on the page)
3. Upload the CSV file
4. View batch prediction results

### CSV Format

Your CSV file should include these columns:
- `customerID` (optional - auto-generated if missing)
- `gender` (Male/Female)
- `SeniorCitizen` (0 or 1)
- `Partner` (Yes/No)
- `Dependents` (Yes/No)
- `tenure` (number of months)
- `PhoneService` (Yes/No)
- `MultipleLines` (Yes/No/No phone service)
- `InternetService` (DSL/Fiber optic/No)
- `OnlineSecurity` (Yes/No/No internet service)
- `OnlineBackup` (Yes/No/No internet service)
- `DeviceProtection` (Yes/No/No internet service)
- `TechSupport` (Yes/No/No internet service)
- `StreamingTV` (Yes/No/No internet service)
- `StreamingMovies` (Yes/No/No internet service)
- `Contract` (Month-to-month/One year/Two year)
- `PaperlessBilling` (Yes/No)
- `PaymentMethod` (Electronic check/Mailed check/Bank transfer (automatic)/Credit card (automatic))
- `MonthlyCharges` (numeric)
- `TotalCharges` (numeric)

### Dashboard

The dashboard provides:
- Total predictions count
- Churn statistics (Yes/No)
- Churn rate percentage
- Interactive pie and bar charts
- Recent prediction history

## Model Details

The KNN (K-Nearest Neighbors) classifier:
- Uses 15 neighbors with distance weighting
- Trained on 2000 sample telecom customer records
- Considers 19 features including demographics, services, and financial metrics
- Provides both prediction (Yes/No) and probability scores

## API Endpoints

- `GET /` - Home page
- `GET /predict` - Prediction form
- `POST /predict` - Submit prediction
- `GET /upload` - CSV upload page
- `POST /upload` - Process CSV file
- `GET /dashboard` - Analytics dashboard
- `GET /about` - About page
- `GET /contact` - Contact page
- `GET /api/stats` - JSON API for statistics

## Database Schema

The SQLite database (`churn_predictions.db`) stores:
- `id`: Primary key
- `timestamp`: Prediction timestamp
- `customer_id`: Customer identifier
- `prediction`: Churn prediction (Yes/No)
- `probability`: Confidence score
- `features`: JSON string of input features

## Development

### Running in Development Mode

The app runs in debug mode by default. To disable:
```python
app.run(debug=False)
```

### Customizing the Model

Edit `train_model.py` to:
- Adjust the number of neighbors
- Modify feature selection
- Change the training dataset size
- Use your own dataset

## Troubleshooting

### Model Not Found Error
- Run `python train_model.py` to generate the model files

### Import Errors
- Ensure all dependencies are installed: `pip install -r requirements.txt`

### Database Errors
- The database is created automatically on first run
- Delete `churn_predictions.db` to reset the database

## License

This project is open source and available for educational purposes.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Contact

For questions or support, visit the Contact page in the application.

---

**Note**: This is a demonstration application. For production use, consider:
- Adding authentication and authorization
- Implementing proper error handling
- Using a production-grade database (PostgreSQL, MySQL)
- Adding input validation and sanitization
- Implementing rate limiting
- Using HTTPS
- Adding logging and monitoring

