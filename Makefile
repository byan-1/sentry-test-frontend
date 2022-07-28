# Must have `sentry-cli` installed globally
# Following variables must be passed in

SENTRY_AUTH_TOKEN=
SENTRY_ORG=hp-cl
SENTRY_PROJECT=web-frontend
REACT_APP_RELEASE_VERSION=v1#`sentry-cli releases propose-version`

setup_release: create_release upload_sourcemaps

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(REACT_APP_RELEASE_VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(REACT_APP_RELEASE_VERSION) \
		upload-sourcemaps --url-prefix "~/static/js" --validate build/static/js
