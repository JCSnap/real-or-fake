# Real or Fake

Is the image real or AI generated? Swipe left if you think it's fake, right if you think it's real!

If you guess correctly, your elo will increase; if you guess incorrectly, your elo will decrease.

## Additional features

Inspired by Captcha's [side purpose](https://medium.com/nerd-for-tech/data-annotation-service-by-typing-captcha-you-are-actually-helping-ai-model-training-5902e8794a6f), apart from making it a fun game, I also want to make use of human expertise to label images.

Ocassionally, we will insert unlabelled images into the game, and the user will be able to guess whether the image is real or fake as per normal.

A user is deemed to be more "reliable" if they have a higher elo score since they are able to correctly label more images. Thus, when making a guess on unlabelled images, their guess will be weighted more heavily in the score calculation.

A score will be given to the unlabelled images based on user guesses, which can be a good heuristic to determine if the image is real or AI generated. It might also serve as useful data for training a model (or not, idk but it would definitely be interesting to see).

## TODO

-   [ ] Get a dataset of real and fake images, implement fetch images from DB
-   [ ] Implement elo algorithm
-   [ ] UI/UX enhancements: effects when guessing correctly/incorrectly (haptic, sound, etc.)
-   [ ] Implement putting in unlabelled image occassionally
-   [ ] Implement algorithm to score unlabelled images based on user guesses and their elo
-   [ ] Implement leaderboard function

## Potential dataset for images

-   [CIFAKE](https://www.kaggle.com/datasets/birdy654/cifake-real-and-ai-generated-synthetic-images?utm_source=chatgpt.com)
-   [GenImage](https://genimage-dataset.github.io/?utm_source=chatgpt.com)
