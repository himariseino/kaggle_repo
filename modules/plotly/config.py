import plotly.graph_objects as go
import plotly.io as pio


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
