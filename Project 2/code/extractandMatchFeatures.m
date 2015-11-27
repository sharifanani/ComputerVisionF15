function [matchedPoints1,matchedPoints2] = extractandMatchFeatures(I1g,I2g)
points1 = detectSURFFeatures(I1g);
points2 = detectSURFFeatures(I2g);

[features1, valid_points1] = extractFeatures(I1g, points1);
[features2, valid_points2] = extractFeatures(I2g, points2);

indexPairs = matchFeatures(features1, features2);
matchedPoints1 = valid_points1(indexPairs(:, 1), :);
matchedPoints2 = valid_points2(indexPairs(:, 2), :);
end