#!/bin/bash

# List connected devices
echo "Listing connected devices..."
flutter devices

# Prompt the user to select a device
echo "Please enter the device ID to run the Flutter app:"
read chrome

# Run the Flutter app on the specified device in the background
echo "Starting Flutter app on device $DEVICE_ID..."
flutter run -d $chrome &

# Get the process ID of the last background command (Flutter)
FLUTTER_PID=$!

# Run the Python script in the background
echo "Starting Python script..."
python3 getSchorlaships2.py &
python3 getScholarship.py &

# Get the process ID of the last background command (Python)
PYTHON_PID=$!

# Wait for both processes to complete
wait $FLUTTER_PID
wait $PYTHON_PID

echo "Both processes have finished."
