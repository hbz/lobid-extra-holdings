default HOST = "localhost"; // pass e.g. test-metadaten-nrw.hbz-nrw.de
default API_TOKEN = ""; // pass e.g. API_TOKEN=e8d...
default PORT = "1337"; // may vary for your local strapi instance
default PATH = "holdings"; // currently only holdings are imported
API_URL = "http://" + HOST + ":" + PORT + "/api/" + PATH;


FLUX_DIR + "../prod/output/sol1Holding_seq2strapi.json.gz"
| open-file
| as-records
| decode-json
| encode-json
| regex-decode("(?<data>.+)")
| stream-to-triples
| template("{\"${p}\":${o}}") // wrap into 'data' object for strapi
| log-object("Will POST: ")
| open-http(url=API_URL, method="POST", contentType="application/json", header="Authorization: Bearer " + API_TOKEN)
| as-lines
| log-object("POST Response: ")
| print
;
