import typer
import os


radar = typer.Typer(help="Awesome CLI user manager.")

@radar.command()
def radar_plot(league: str = "Liga MX", player: str = "H. Martín"):
    cmd = f"Rscript src/calculate_quantiles_of_subgroups.R -p '{player}'"
    os.system(cmd)
    cmd = f"Rscript src/plot_pca_variables_of_players.R -p '{player}' -l '{league}'"
    os.system(cmd)

if __name__ == "__main__":
    radar()