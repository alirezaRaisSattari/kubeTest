#!/bin/sh

echo "Waiting for MongoDB to be ready..."
until nc -z mongodb 27017; do
  echo "MongoDB is unavailable - sleeping"
  sleep 2
done

echo "MongoDB is up - executing command" 