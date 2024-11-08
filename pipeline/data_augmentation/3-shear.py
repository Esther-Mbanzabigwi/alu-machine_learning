import tensorflow as tf

def shear_image(image, intensity):
    """
    Randomly shears an image.
    
    Parameters:
    - image: a 3D tf.Tensor containing the image to shear
    - intensity: a float representing the intensity of the shear (in degrees)
    
    Returns:
    - A 3D tf.Tensor containing the sheared image
    """
    # Convert intensity from degrees to radians
    intensity = tf.constant(intensity, dtype=tf.float32) * (3.14159265 / 180.0)
    
    # Define the transformation matrix for shearing
    shear_matrix = [[1.0, -tf.math.sin(intensity), 0.0],
                    [0.0, tf.math.cos(intensity), 0.0],
                    [0.0, 0.0, 1.0]]
    
    # Apply the transformation
    image_shape = tf.shape(image)
    sheared_image = tf.raw_ops.ImageProjectiveTransformV2(
        images=tf.expand_dims(image, 0),
        transforms=tf.reshape(shear_matrix[:2], [-1]),
        output_shape=image_shape[:2],
        interpolation="BILINEAR"
    )
    
    return tf.squeeze(sheared_image)
