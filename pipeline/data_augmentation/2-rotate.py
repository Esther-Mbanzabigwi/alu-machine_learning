import tensorflow as tf

def rotate_image(image):
    """
    Rotates an image by 90 degrees counter-clockwise.
    
    Parameters:
    - image: a 3D tf.Tensor containing the image to rotate
    
    Returns:
    - A 3D tf.Tensor containing the rotated image
    """
    return tf.image.rot90(image, k=1)
