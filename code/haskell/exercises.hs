module Exercises
  ( firstThenApply
  , powers
  , meaningfulLineCount
  , Shape(..)
  , volume
  , surfaceArea
  , BST(Empty)
  , insert
  , contains
  , size
  , inorder
  ) where


import Data.Char (isSpace)
import Data.List (find)

firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs p f = f <$> find p xs

powers :: Integral a => a -> [a]
powers b = iterate (* b) 1

meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount path = do
    s <- readFile path
    let ok l = case dropWhile isSpace l of
                []      -> False
                ('#':_) -> False
                _       -> True
    pure . length . filter ok $ lines s

data Shape
    = Box Double Double Double
    | Sphere Double
    deriving (Eq)

volume :: Shape -> Double
volume (Box a b c) = a * b * c
volume (Sphere r)  = (4 / 3) * pi * r ^ (3 :: Int)

surfaceArea :: Shape -> Double
surfaceArea (Box a b c) = 2 * (a*b + b*c + a*c)
surfaceArea (Sphere r)  = 4 * pi * r ^ (2 :: Int)

instance Show Shape where
  show (Sphere r)  = "Sphere " ++ show r
  show (Box a b c) = "Box " ++ show a ++ " " ++ show b ++ " " ++ show c

data BST a
  = Empty
  | Node (BST a) a (BST a)

insert :: Ord a => a -> BST a -> BST a
insert x Empty = Node Empty x Empty
insert x (Node l v r)
  | x < v     = Node (insert x l) v r
  | x > v     = Node l v (insert x r)
  | otherwise = Node l v r

contains :: Ord a => a -> BST a -> Bool
contains _ Empty = False
contains x (Node l v r)
  | x < v     = contains x l
  | x > v     = contains x r
  | otherwise = True

size :: BST a -> Int
size Empty = 0
size (Node l _ r) = 1 + size l + size r

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node l v r) = inorder l ++ [v] ++ inorder r

instance Show a => Show (BST a) where
    show Empty = "()"
    show (Node l v r) = "(" ++ left ++ show v ++ right ++ ")"
      where
        left  = case l of Empty -> "" ; _ -> show l
        right = case r of Empty -> "" ; _ -> show r
