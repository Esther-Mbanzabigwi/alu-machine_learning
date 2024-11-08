import tensorflow as tf

def flip_image(image):
    """
    Flips an image horizontally.
    
    Parameters:
    - image: a 3D tf.Tensor containing the image to flip
    
    Returns:
    - A 3D tf.Tensor containing the horizontally flipped image
    """
    return tf.image.flip_left_right(image)
