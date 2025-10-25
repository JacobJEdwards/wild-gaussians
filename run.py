from pathlib import Path
import subprocess

BASE_DIR = Path("/workspace/360_v2")
OUTPUT_DIR = Path("/workspace/wild-gs/variance")

def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    for scene in BASE_DIR.iterdir():
        if not scene.is_dir():
            continue

        scene_name = scene.name
        output_scene_dir = OUTPUT_DIR / scene_name
        output_scene_dir.mkdir(parents=True, exist_ok=True)

        command = ["nerfbaselines", "train", "--method", "wild-gaussians", "--data", str(scene), "--output",
                   str(output_scene_dir), "--backend", "python"]

        print(f"Processing scene: {scene_name}")

        subprocess.run(command, check=True, cwd=output_scene_dir)

if __name__ == "__main__":
    main()