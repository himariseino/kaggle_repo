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
    path_to_save_figure: Path = Path("../outputs/figures")

    @classmethod
    def set_custom_plotly_template(
        cls,
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
                paper_bgcolor=cls.COLORS["background"],
                plot_bgcolor=cls.COLORS["background"],
            )
        )
        pio.templates.default = "custom_template"

    @classmethod
    def save_png(
        cls, fig: go.Figure, filename: str, width: int = 1200, height: int = 500
    ):
        fig.write_image(
            cls.path_to_save_figure / f"{filename}.png", width=width, height=height
        )
