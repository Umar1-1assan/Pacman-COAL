# Basic CLI Pacman Game - Assembly Language

This project implements a basic CLI-based version of the classic Pacman game using Assembly Language. The goal of this project is to gain a deeper understanding of **Computer Organization** and **Assembly Language** programming by building a game that involves handling user input, memory management, and display output at the machine level.

## Features:
- **Basic Gameplay**: The game mimics the classic Pacman mechanics, where the player controls Pacman to eat pellets while avoiding ghosts. The game is displayed in a text-based format on the command line interface (CLI).
- **Movement**: The player can move Pacman in four directions (up, down, left, right) using keyboard input. The movement is handled efficiently by using Assembly’s low-level memory access and control flow instructions.
- **Ghosts**: Ghosts move in a simple pattern and the player must avoid them to survive. Collision detection between Pacman and ghosts is implemented at the byte level, using Assembly's ability to directly manipulate memory and registers.
- **Scorekeeping**: The player earns points by eating pellets. The score is displayed on the screen and updated as the player progresses through the game.
  
## Concepts Demonstrated:
- **Computer Organization**: The project helps demonstrate key aspects of computer architecture, such as memory management, processor registers, and I/O operations. Through Assembly Language, the game implements direct manipulation of memory and registers to control game logic and display.
- **Low-Level Programming**: Assembly Language is used to handle the game’s core logic, including input handling, game state updates, and output rendering to the CLI. This helps develop an understanding of how high-level constructs (like movement, game loops, and collision detection) are implemented at the hardware level.
- **Memory Management**: The game directly interacts with memory to store game data such as Pacman's position, the state of the ghosts, and the score. Memory allocation, addressing, and optimization are crucial aspects of this project.
  
## Technologies Used:
- **Assembly Language**: The entire game is written in Assembly Language, targeting a specific processor architecture to interact directly with the hardware.
- **CLI**: The game runs in the command line interface, displaying the game state using text characters and handling user input through keyboard keys.

## Learning Outcomes:
- **Understanding Assembly Language**: Writing the game in Assembly Language allows for an in-depth understanding of how instructions are executed at the hardware level, providing insights into how higher-level programming constructs are translated into machine code.
- **Computer Organization**: The project reinforces concepts in computer organization, including memory addressing, control flow, and processor registers, all of which are essential for understanding how computers operate at the lowest level.
- **Game Loop and Event Handling**: The game loop and event handling in the game are managed through Assembly, offering a hands-on approach to understanding how real-time applications work at the assembly level.

## Getting Started:
1. Clone the repository.
2. Set up an assembler (e.g., NASM) to compile the Assembly code.
3. Run the compiled code in a terminal or command prompt to play the game.
