import plotly.graph_objects as go
import plotly.io as pio

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


def set_custom_plotly_template(
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


if __name__ == "__main__":
    set_custom_plotly_template()
