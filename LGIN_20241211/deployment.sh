
#!/bin/bash

# Get the current directory where the script is located
DEPLOY_DIR=$(dirname "$(realpath "$0")")

# Set the repository URL (change this to your actual repository)
REPO_URL="https://github.com/josseMolenschot/Flask_login_deploy.git"

# Function to clean up the deployment directory
cleanup() {
    echo "Cleaning up deployment directory: $DEPLOY_DIR"
    rm -rf "$DEPLOY_DIR"
    echo "Cleanup complete."
}

# Set a trap to clean up when the script receives an interrupt signal (Ctrl+C) or exits
trap cleanup EXIT

# Check if the directory is already present
if [ ! -d "$DEPLOY_DIR/.git" ]; then
    echo "Cloning repository into $DEPLOY_DIR..."
    git clone "$REPO_URL" "$DEPLOY_DIR"
fi

# Navigate to the deployment directory
cd "$DEPLOY_DIR"

# Create and activate a virtual environment
echo "Setting up Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install dependencies from requirements.txt
echo "Installing dependencies..."
pip install -r requirements.txt

# Run the Flask application
echo "Starting the Flask application..."
python app.py