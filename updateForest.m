%wind direction (1 for north, 2 for east, 3 for south, 4 for west)
windDirection = 3;

% Modify fire propagation rules based on wind direction
for t = 1:numTimeSteps
    % Create a copy of the forest grid to update states simultaneously
    newForestGrid = forestGrid;
    
    % Loop through each cell in the forest grid
    for r = 2:rows-1
        for c = 2:cols-1
            if forestGrid(r, c) == 0 % If the cell is a healthy tree
                % Count burning neighbors (Moore neighborhood)
                burningNeighbors = sum(sum(forestGrid(r-1:r+1, c-1:c+1) == BURNING)) - (forestGrid(r, c) == BURNING);
                
                % Adjust fire spread probability based on wind direction
                if windDirection == 1 % North
                    burningNeighbors = burningNeighbors + (forestGrid(r-1, c) == BURNING);
                elseif windDirection == 2 % East
                    burningNeighbors = burningNeighbors + (forestGrid(r, c+1) == BURNING);
                elseif windDirection == 3 % South
                    burningNeighbors = burningNeighbors + (forestGrid(r+1, c) == BURNING);
                elseif windDirection == 4 % West
                    burningNeighbors = burningNeighbors + (forestGrid(r, c-1) == BURNING);
                end
                
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
    
    % Update the forest grid
    forestGrid = newForestGrid;
    
    % Visualization 
    imagesc(forestGrid);
    colormap([0 1 0; 1 0 0; 0.5 0.5 0.5]); % Green for healthy, Red for burning, Gray for burnt
    title(['Time Step: ', num2str(t)]);
    pause(0.1);
end
