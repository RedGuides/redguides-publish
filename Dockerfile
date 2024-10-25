FROM python:3.12-slim

# Install redfetch
RUN pip install -index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ redfetch==0.1.69.dev29

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]