FROM python:3.11-alpine AS build

WORKDIR /app

RUN pip uninstall -y setuptools
# correcting high cves found with trivy
RUN rm -rf /usr/local/lib/python3.11/site-packages/setuptools* \
           /usr/local/lib/python3.11/site-packages/pkg_resources*

RUN pip install --no-cache-dir setuptools==78.1.0

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# correcting high cves found with trivy
RUN pip install --force-reinstall starlette==0.40.0

FROM python:3.11-alpine

WORKDIR /app

# correcting cves found with trivy
RUN pip uninstall -y setuptools
# correcting cves found with trivy
RUN rm -rf /usr/local/lib/python3.11/site-packages/setuptools* \
           /usr/local/lib/python3.11/site-packages/pkg_resources*

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=build /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/
COPY --from=build /usr/local/bin/ /usr/local/bin/

COPY app.py .

RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 3000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "3000", "--log-level", "info", "--no-access-log"]