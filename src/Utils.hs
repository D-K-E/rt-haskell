-- utility function
module Utils where

infty :: Double
infty = (read "Infinity") :: Double

m_pi :: Double
m_pi = 3.141592653589793238

degrees_to_radians :: Double -> Double
degrees_to_radians degrees = degrees * m_pi / 180.0