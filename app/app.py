import os
import warnings

import dash
from dash import html

warnings.filterwarnings("ignore")

app = dash.Dash(
    __name__, assets_folder=os.path.join(os.path.dirname(__file__), "assets")
)
app.title = "sample-app"
app.layout = html.Div([])


def main():
    app.run_server(debug=True)


if __name__ == "__main__":
    main()
