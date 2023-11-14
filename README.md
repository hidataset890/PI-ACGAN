# PI-ACGAN: Polarization imaging shadow removal based on attention conditional generative adversarial networks

## Requirements
* Python3.x
* PyTorch 1.5.0
* pillow
* matplotlib


For data folder path (PZ), train_A: shadow images, train_B: shadow masks, train_C: shadow free images, organize them as following:

```shell
--PZ
   --train
      --train_A
          --1-1.jpg
      --train_B
          --1-1.jpg 
      --train_C
          --1-1.jpg

   --test
      --test_A
          --1-1.jpg
      --test_B
          --1-1.jpg
      --test_C
          --1-1.jpg

 ```
 

Then,
### Training
```
python3 train.py
```
### Testing
When Testing images from PZ dataset.
```
python3 test.py -l <checkpoint number>
```
When you would like to test your own image.
```
python3 test.py -l <checkpoint number> -i <image_path> -o <out_path>
```

