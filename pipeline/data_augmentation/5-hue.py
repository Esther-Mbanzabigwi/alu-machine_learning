import tensorflow as tf

def change_hue(image, delta):
    """
    Changes the hue of an image by a specified delta.
    
    Parameters:
    - image: a 3D tf.Tensor containing the image to change
    - delta: a float representing the amount to adjust the hue (values between -1.0 and 1.0)
    
    Returns:
    - A 3D tf.Tensor containing the image with adjusted hue
    """
    return tf.image.adjust_hue(image, delta)
