# DC Motor Digital Twin

A neural-network-based digital twin of a permanent magnet DC motor, developed using MATLAB, Simulink, and Python.

The project explores how neural networks can learn the dynamic behaviour of a simulated motor and how well their predictions match its simulated response.

## Project Objectives

- Generate motor simulation data under different voltage and load-torque conditions.
- Establish a feedforward neural network baseline.
- Train and compare Recurrent Neural Network (RNN), Long Short-Term Memory (LSTM), and Gated Recurrent Unit (GRU) models.
- Evaluate model performance during one-step prediction, multi-step rollout, transient response, and steady-state operation.

## Project Structure

```text
dc-motor-digital-twin/
├── data/
│   ├── motor_dataset.csv
│   └── motor_dataset_fixed_time.csv
├── matlab/
│   ├── build_fixed_time_dataset.m
│   └── generate_simulation_data.m
├── models/
│   ├── gru_model.keras
│   ├── input_scaler.pkl
│   ├── lstm_model.keras
│   ├── output_scaler.pkl
│   └── rnn_model.keras
├── notebooks/
│   ├── 01_feedforward_baseline.ipynb
│   ├── 02_dynamic_neural_network.ipynb
│   └── 03_digital_twin_validation.ipynb
├── .gitignore
├── README.md
└── requirements.txt
```

## Technologies

- MATLAB and Simulink
- Python
- TensorFlow and Keras
- NumPy and pandas
- Matplotlib
- scikit-learn
- joblib
- Jupyter Notebook

## Setup

Python 3.14.6 was used during development.

1. Clone this repository.
2. Create and activate a Python environment compatible with the dependencies in `requirements.txt`.
3. Install the dependencies:

   ```bash
   python -m pip install -r requirements.txt
   ```

4. Launch Jupyter Notebook:

   ```bash
   jupyter notebook
   ```

5. Open the notebooks in the `notebooks/` directory and run them in numerical order.

The supplied CSV datasets and trained models are included in the repository. MATLAB and Simulink are not required to run the notebooks using these existing files.

## Workflow

### 1. Use the Provided Datasets

The `data/` directory contains the generated motor simulation datasets:

- `motor_dataset.csv` — dataset used for the feedforward baseline.
- `motor_dataset_fixed_time.csv` — dataset sampled at 1 ms intervals for the dynamic neural-network experiments.

Both datasets are provided and ready to use.

### 2. Train the Models

Run the notebooks in numerical order:

1. `01_feedforward_baseline.ipynb` — establishes a feedforward neural network baseline and compares it with linear regression.
2. `02_dynamic_neural_network.ipynb` — trains and compares RNN, LSTM, and GRU models.
3. `03_digital_twin_validation.ipynb` — evaluates the trained models against simulated motor behaviour.

Notebook 2 saves the trained recurrent models and scalers in `models/`. Notebook 3 loads these files for validation.

### 3. Explore the Simulation Scripts

The MATLAB scripts in `matlab/` document how the datasets were generated. The Simulink model files are kept locally and are not included in the repository.

Regenerating the datasets requires the corresponding Simulink models and a compatible MATLAB/Simulink installation. The supplied CSV files allow users to work through the notebooks without regenerating the simulations.

## Models and Evaluation

The project compares a feedforward neural network with RNN, LSTM, and GRU architectures.

Evaluation includes prediction errors and the models' ability to reproduce motor behaviour over time, including startup, load application, and steady-state operation.

### Steady-State Evaluation

The LSTM achieved the lowest steady-state prediction errors among the three recurrent models on held-out simulated motor trajectories.

| Model | Current MAE (A) | Speed MAE (rpm) |
|---|---:|---:|
| RNN | 0.03378 | 1,686.84031 |
| LSTM | 0.00270 | 202.92492 |
| GRU | 0.00799 | 532.84986 |

These results measure agreement with the MATLAB/Simulink reference model, not physical motor measurements. See Notebook 3 for the full transient and steady-state evaluation.

## Limitations

This digital twin is developed and evaluated using simulated motor data. Its performance on real hardware has not been established.

The results should therefore be interpreted as validation against a simulation model, not as proof of equivalent accuracy on a physical motor.