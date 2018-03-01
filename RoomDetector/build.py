import turicreate as tc

#Define where the cat can be found in image
annotations = tc.SArray([
[
{'label': 'painting82', 'type': 'rectangle', 'coordinates': {'height': 553.0, 'width': 557.0, 'x': 818.0, 'y': 662.0}}
],
[
{'label': 'painting83', 'type': 'rectangle', 'coordinates': {'height': 725, 'width': 625, 'x': 736, 'y': 636}}
],
[
{'label': 'painting84', 'type': 'rectangle', 'coordinates': {'height': 735, 'width': 661, 'x': 396, 'y': 568}}
],
[
{'label': 'painting85', 'type': 'rectangle', 'coordinates': {'height': 397, 'width': 375, 'x': 640, 'y': 637}}
],
[
{'label': 'painting86', 'type': 'rectangle', 'coordinates': {'height': 512, 'width': 432, 'x': 598, 'y': 618}}
],
[
{'label': 'painting87', 'type': 'rectangle', 'coordinates': {'height': 563, 'width': 519, 'x': 757, 'y': 666}}
],
[
{'label': 'painting88', 'type': 'rectangle', 'coordinates': {'height': 913, 'width': 661, 'x': 672, 'y': 661}}
],
[
{'label': 'painting89', 'type': 'rectangle', 'coordinates': {'height': 927, 'width': 632, 'x': 762, 'y': 737}}
],
[
{'label': 'painting90', 'type': 'rectangle', 'coordinates': {'height': 459, 'width': 373, 'x': 686, 'y': 648}}
],
[
{'label': 'painting91', 'type': 'rectangle', 'coordinates': {'height': 301, 'width': 220, 'x': 622, 'y': 765}}
],
[
{'label': 'painting92', 'type': 'rectangle', 'coordinates': {'height': 397, 'width': 210, 'x': 570, 'y': 683}}
],
[
{'label': 'painting93', 'type': 'rectangle', 'coordinates': {'height': 361, 'width': 222, 'x': 812, 'y': 869}}
],
[
{'label': 'painting94', 'type': 'rectangle', 'coordinates': {'height': 351, 'width': 308, 'x': 833, 'y': 624}}
],
[
{'label': 'painting95', 'type': 'rectangle', 'coordinates': {'height': 334, 'width': 331, 'x': 694, 'y': 707}}
],
[
{'label': 'painting96', 'type': 'rectangle', 'coordinates': {'height': 846, 'width': 555, 'x': 601, 'y': 594}}
],
[
{'label': 'painting97', 'type': 'rectangle', 'coordinates': {'height': 930, 'width': 724, 'x': 692, 'y': 669}}
],
[
{'label': 'painting98', 'type': 'rectangle', 'coordinates': {'height': 804, 'width': 814, 'x': 572, 'y': 694}}
],
[
{'label': 'painting99', 'type': 'rectangle', 'coordinates': {'height': 901, 'width': 733, 'x': 518, 'y': 669}}
],
[
{'label': 'painting100', 'type': 'rectangle', 'coordinates': {'height': 929, 'width': 570, 'x': 532, 'y': 620}}
],
[
{'label': 'painting101', 'type': 'rectangle', 'coordinates': {'height': 562, 'width': 485, 'x': 655, 'y': 638}}
],
[
{'label': 'painting102', 'type': 'rectangle', 'coordinates': {'height': 479, 'width': 469, 'x': 818, 'y': 628}}
],
[
{'label': 'painting103', 'type': 'rectangle', 'coordinates': {'height': 437, 'width': 436, 'x': 774, 'y': 506}}
],
[
{'label': 'painting104', 'type': 'rectangle', 'coordinates': {'height': 383, 'width': 366, 'x': 645, 'y': 513}}
],
[
{'label': 'painting105', 'type': 'rectangle', 'coordinates': {'height': 350, 'width': 312, 'x': 724, 'y': 615}}
],
[
{'label': 'painting106', 'type': 'rectangle', 'coordinates': {'height': 417, 'width': 340, 'x': 734, 'y': 600}}
],
[
{'label': 'painting107', 'type': 'rectangle', 'coordinates': {'height': 373, 'width': 253, 'x': 727, 'y': 628}}
],
[
{'label': 'painting108', 'type': 'rectangle', 'coordinates': {'height': 318, 'width': 267, 'x': 709, 'y': 639}}
],
[
{'label': 'painting109', 'type': 'rectangle', 'coordinates': {'height': 274, 'width': 213, 'x': 581, 'y': 612}}
],
[
{'label': 'painting110', 'type': 'rectangle', 'coordinates': {'height': 331, 'width': 296, 'x': 620, 'y': 582}}
],
[
{'label': 'painting111', 'type': 'rectangle', 'coordinates': {'height': 394, 'width': 391, 'x': 517, 'y': 572}}
]
])

#load images
images = tc.SArray([
tc.Image('images/IMG_0082.jpeg'),
tc.Image('images/IMG_0083.jpeg'),
tc.Image('images/IMG_0084.jpeg'),
tc.Image('images/IMG_0085.jpeg'),
tc.Image('images/IMG_0086.jpeg'),
tc.Image('images/IMG_0087.jpeg'),
tc.Image('images/IMG_0088.jpeg'),
tc.Image('images/IMG_0089.jpeg'),
tc.Image('images/IMG_0090.jpeg'),
tc.Image('images/IMG_0091.jpeg'),
tc.Image('images/IMG_0092.jpeg'),
tc.Image('images/IMG_0093.jpeg'),
tc.Image('images/IMG_0094.jpeg'),
tc.Image('images/IMG_0095.jpeg'),
tc.Image('images/IMG_0096.jpeg'),
tc.Image('images/IMG_0097.jpeg'),
tc.Image('images/IMG_0098.jpeg'),
tc.Image('images/IMG_0099.jpeg'),
tc.Image('images/IMG_0100.jpeg'),
tc.Image('images/IMG_0101.jpeg'),
tc.Image('images/IMG_0102.jpeg'),
tc.Image('images/IMG_0103.jpeg'),
tc.Image('images/IMG_0104.jpeg'),
tc.Image('images/IMG_0105.jpeg'),
tc.Image('images/IMG_0106.jpeg'),
tc.Image('images/IMG_0107.jpeg'),
tc.Image('images/IMG_0108.jpeg'),
tc.Image('images/IMG_0109.jpeg'),
tc.Image('images/IMG_0110.jpeg'),
tc.Image('images/IMG_0111.jpeg')
])

data = tc.SFrame({'image': images, 'annotations': annotations})

train_data, test_data = data.random_split(0.8)
# Create a model
model = tc.object_detector.create(train_data, max_iterations=1000)

# Save predictions to an SArray
predictions = model.predict(test_data)

# Evaluate the model and save the results into a dictionary
metrics = model.evaluate(test_data)

# Save the model for later use in Turi Create
model.save('painting.model')
model.export_coreml("Painting.mlmodel")
