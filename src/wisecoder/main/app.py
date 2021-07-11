import logging
import logging.config
import logging.handlers
from flask import Flask
from flask_restful import Api

from src.wisecoder import ma
from src.wisecoder.main.resources.health import Health
from src.wisecoder.main.utils.envvars import load_env_vars

API_ROOT = "/wisecoder"


def create_app():
    app = Flask(__name__)
    api = Api(app)
    load_env_vars(app.config)

    log = logging.getLogger(__name__)

    app.app_context().push()
    with app.app_context():
        ma.init_app(app)
        api.add_resource(Health, API_ROOT + "/health")
        # app.register_blueprint(errors)
        log.debug("db initialised...")
        # db.init_app(app)
        print(app.url_map)
        log.debug(app.url_map)
    return app


if __name__ == "__main__":
    app = create_app()
    app.run(host='0.0.0.0', port=app.config["SERVER_PORT"])
