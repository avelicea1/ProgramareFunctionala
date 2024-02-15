module BmiCli where
import System.Environment (getArgs)
-- main = putStrLn "Complete this program"
--ex 10.8.4
main :: IO ()
main = do
  args <- getArgs
  case args of
    [weightStr, heightStr] -> do
      let weight = read weightStr :: Double
          height = read heightStr :: Double

      let bmi = calculateBMI weight height

      putStrLn $ show bmi
    _ -> putStrLn "Please provide valid arguments for weight and height."

calculateBMI :: Double -> Double -> Double
calculateBMI weight height = weight / (height ^ 2)