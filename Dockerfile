# Use the official n8n Docker image
FROM n8nio/n8n:latest

# Expose the default n8n port
EXPOSE 5678

# Run n8n when the container starts
CMD ["n8n"]
