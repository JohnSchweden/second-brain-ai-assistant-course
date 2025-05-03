#!/bin/bash

# Define your project directories
INFRASTRUCTURE_DIR="../apps/infrastructure/docker"
DATA_PIPELINE_DIR="./apps/second-brain-offline/pipelines"  # Change this as needed
MONGODB_CONTAINER="docker-local_dev_atlas-1"

# Define startup sequence
start() {
  echo "🔧 Moving to folder..." 
  cd second-brain-ai-assistant-course 
  cd second-brain-ai-assistant-course/apps/second-brain-offline

  echo "🔧 Starting virtual environment..."
  source ./.venv-offline/bin/activate
  
  echo "🔧 Starting infrastructure..."
  make local-infrastructure-up
  #docker compose -f "$INFRASTRUCTURE_DIR/docker-compose.yml" up --build -d

  #echo "🚀 Starting ZenML daemon server..."
  #zenml up

  #echo "🧠 Running dataset pipeline..."
  #make generate-dataset-pipeline
}

# Define shutdown sequence
stop() {
  echo "🛑 Shutting down ZenML daemon server..."
  zenml down

  echo "🛑 Stopping infrastructure..."
  make local-infrastructure-down
  #docker compose -f "$INFRASTRUCTURE_DIR/docker-compose.yml" down

  echo "🛑 Stopping virtual environment..."
  deactivate

  echo "✅ All services stopped."
}

# Help
usage() {
  echo "Usage: $0 {start|stop}"
  exit 1
}

# Execute
case "$1" in
  start) start ;;
  stop) stop ;;
  *) usage ;;
esac
