module Bmi where
--ex 10.8.3
-- main = putStrLn "Complete this program"
main :: IO ()
main = do
  putStrLn "Please enter your weight (in kilograms):"
  weightStr <- getLine
  let weight = read weightStr :: Double

  putStrLn "Please enter your height (in meters):"
  heightStr <- getLine
  let height = read heightStr :: Double

  let bmi = calculateBMI weight height

  putStrLn $ "Your BMI is: " ++ show bmi

calculateBMI :: Double -> Double -> Double
calculateBMI weight height = weight / (height ^ 2)