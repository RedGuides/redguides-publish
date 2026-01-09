FROM python:3.12-slim

# Install redfetch from TestPyPI, but allow dependencies to resolve from PyPI.
# (TestPyPI often doesn't host all dependencies.)
RUN pip install --pre --index-url https://test.pypi.org/simple --extra-index-url https://pypi.org/simple redfetch

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
