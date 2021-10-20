{-# LANGUAGE BangPatterns #-}
-- hittable object module
module Hittable.HittableObj where

import Hittable.Hittable
import Hittable.Sphere
import Hittable.MovingSphere
import Hittable.AaRect

data HittableObj = HitSphere !Sphere 
                 | MvHitSphere !MovingSphere
                 | AaQuad AaRect
                 deriving (Show, Eq)

instance Hittable HittableObj where
    hit !(HitSphere s) !ry !tmin !tmax !hrec = hit s ry tmin tmax hrec
    hit !(MvHitSphere s) !ry !tmin !tmax !hrec = hit s ry tmin tmax hrec
    hit !(AaQuad s) !ry !tmin !tmax !hrec = hit s ry tmin tmax hrec
    boundingBox (MvHitSphere s) time0 time1 ab = boundingBox s time0 time1 ab
    boundingBox (HitSphere s) time0 time1 ab = boundingBox s time0 time1 ab
    boundingBox (AaQuad s) time0 time1 ab = boundingBox s time0 time1 ab

