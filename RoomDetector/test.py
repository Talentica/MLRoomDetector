import turicreate as tc
#load image
test = tc.SFrame({'image': [tc.Image('images/IMG_0087.jpeg')]})
#load the model
model = tc.load_model('painting.model')
test['predictions'] = model.predict(test)
print(test['predictions'])

#this part work only on Mac
test['image_with_predictions'] = \
    tc.object_detector.util.draw_bounding_boxes(test['image'], test['predictions'])
test.explore()
