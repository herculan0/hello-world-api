
from fastapi import FastAPI, Request
from fastapi.responses import RedirectResponse, Response
import time
import json
import logging

logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger("api")

app = FastAPI()


@app.middleware("http")
async def log_requests(request: Request, call_next):
    method = request.method
    path = request.url.path

    response = await call_next(request)

    log_entry = {
        "custom_log": True,
        "method": method,
        "path": path,
        "params": dict(request.query_params),
        "status_code": response.status_code,
        "timestamp": int(time.time())
    }

    logger.info(json.dumps(log_entry))

    return response


@app.get("/", include_in_schema=False)
async def root():
    return RedirectResponse(url="/hello_world")


@app.get("/hello_world")
async def hello_world():
    return {"message": "Hello World!"}


@app.get("/current_time")
async def current_time(name: str = None):
    return {
        "timestamp": int(time.time()),
        "message": f"Hello {name or 'Guest'}"
    }


@app.get("/healthcheck")
async def healthcheck():
    return {"status": "healthy"}


@app.get("/favicon.ico", include_in_schema=False)
async def favicon():
    return Response(status_code=204)  # No content response
