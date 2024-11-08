import tensorflow as tf

def crop_image(image, size):
    """
    Performs a random crop of an image.
    
    Parameters:
    - image: a 3D tf.Tensor containing the image to crop
    - size: a tuple (height, width, channels) specifying the size of the crop
    
    Returns:
    - A 3D tf.Tensor containing the cropped image
    """
    return tf.image.random_crop(image, size)
