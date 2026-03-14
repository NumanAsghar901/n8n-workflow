# Use the official n8n Docker image
FROM n8nio/n8n:latest

# Set environment variable for n8n
ENV N8N_PORT=5678

# Expose the default n8n port
EXPOSE 5678

# Start n8n using the full path
CMD ["n8n", "start"]
