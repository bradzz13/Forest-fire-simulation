function forest = initializeForest(Rows, Cols, initialFires)
    % Initialize forest as a matrix of zeros (healthy trees)
    forest = zeros(Rows, Cols);
    % Randomly set some trees on fire
    initialFireIndices = randperm(Rows * Cols, initialFires);
    forest(initialFireIndices) = 1; % 1 represents burning trees
end