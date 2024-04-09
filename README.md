# FEM Solver for Bar and Beam Problems using Bar/Truss Elements

## Project Overview

This project implements a Finite Element Method (FEM) solver in MATLAB for analyzing bar and beam problems using bar/truss elements. The solver uses the Gauss points restriction method and handles different types of boundary conditions (Dirichlet, Neumann, and Spring).

## Features

- Supports P order of interpolation function for element with a limit of P = 6 due to Gauss points restriction.
- Allows for a user-defined number of elements (`e`) within the domain of interest.
- Customizable domain range from `x0` to `xL`.
- Interactive user input for boundary conditions and point load presence and properties.

## How to Use

1. Ensure MATLAB is installed on your system.
2. Download the `.m` file from the repository.
3. Run the script in MATLAB.
4. Follow the command window prompts to input boundary conditions at `x0` and `xL`.
   - Options: 
     1. Dirichlet
     2. Neumann
     3. Spring
5. Input point load information when prompted.
6. The program will automatically adjust the number of elements if a point load is not on a node.
7. Review the output for nodal displacement values and interpolation functions.

## Input Data Format

- Boundary conditions are specified at `x0` and `xL`.
- For Dirichlet conditions, input displacement value `u`.
- For Neumann conditions, input the derivative value `AE*(du/dx)`.
- For Spring conditions, input spring constant `K` and displacement `Del`.
- If a point load is present, input its value and location.

## Output Data

The solver outputs:
- The global stiffness matrix `K_global_D_bc`.
- Nodal displacement values `u_nodes`.
- Interpolation functions for each element.
- A table with nodal locations, displacement values, and `du/dx` values.
- Plots comparing the FEM solution to the exact solution for both `u` and `u'`.

## Sample Output

The MATLAB command window will display tables and plots representing the solution. These include nodal locations, displacements, and the derivative of displacement across the domain.

## Contact

For questions or collaborations, please reach out to `r-suresh@outlook.com`.
