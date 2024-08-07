rows = 100; % Number of rows in the forest grid
cols = 100; % Number of columns in the forest grid

%the number of initial fires
initialFires =1; 

% Initialize the forest grid using the custom function
forestGrid = initializeForest(rows, cols, initialFires);

% number of time steps for the simulation
numTimeSteps = 10;

%burning and burnt states
BURNING = 1;
BURNT = 2;

% Time step for burning duration
burningDuration = 3; %tree burns for 3 time steps

% Initialize an array to track burning time
burningTime = zeros(rows, cols);

% Simulation loop
for t = 1:numTimeSteps
    % Create a copy of the forest grid to update states simultaneously
    newForestGrid = forestGrid;
    
    % Loop through each cell in the forest grid
    for r = 2:rows-1
        for c = 2:cols-1
            if forestGrid(r, c) == 0 % If the cell is a healthy tree
                % Count burning neighbors (Moore neighborhood)
                burningNeighbors = sum(sum(forestGrid(r-1:r+1, c-1:c+1) == BURNING)) - (forestGrid(r, c) == BURNING);
                
                % If two or more neighbors are burning, the tree catches fire
                if burningNeighbors >= 2
                    newForestGrid(r, c) = BURNING;
                end
            elseif forestGrid(r, c) == BURNING % If the cell is burning
                % Update burning time
                burningTime(r, c) = burningTime(r, c) + 1;
                
                % If burning duration is reached, transition to burnt
                if burningTime(r, c) >= burningDuration
                    newForestGrid(r, c) = BURNT;
                end
            end
        end
    end
end
