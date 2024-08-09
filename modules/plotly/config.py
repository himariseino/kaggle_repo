from pathlib import Path

import plotly.graph_objects as go
import plotly.io as pio


class PlotlyConfig:
    COLORS = {
        "background": "#FCFCFC",
        "base": "#003366",
        "primary": "#F56B60",
        "secondary": "#20B2AA",
        "success": "#28A745",
        "info": "#17A2B8",
        "warning": "#FFC107",
        "danger": "#DC3545",
        "light": "#F8F9FA",
        "dark": "#343A40",
    }

    def __init__(self, path_to_save_figure: Path = Path("../outputs/figures")):
        self.set_custom_plotly_template()
        self.path_to_save_figure = path_to_save_figure

    def set_custom_plotly_template(
        self,
        paper_bgcolor: str = "#fcfcfc",
        plot_bgcolor: str = "#fcfcfc",
    ) -> None:
        """
        Set custom template for Plotly.

        Args:
            paper_bgcolor (str): Background color of the paper.
            plot_bgcolor (str): Background color of the plot.

        Returns:
            None

        Docs:
            https://plotly.com/python/templates/
        """
        pio.templates["custom_template"] = go.layout.Template(
            layout=go.Layout(
                paper_bgcolor=paper_bgcolor,
                plot_bgcolor=plot_bgcolor,
            )
        )
        pio.templates.default = "custom_template"

    def save_png(
        self, fig: go.Figure, filename: str, width: int = 1200, height: int = 500
    ):
        fig.write_image(
            self.path_to_save_figure / f"{filename}.png", width=width, height=height
        )
