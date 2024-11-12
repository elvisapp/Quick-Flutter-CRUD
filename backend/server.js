const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

app.use(bodyParser.json());
app.use(cors({ origin: '*' }));  // Permite todas las conexiones

mongoose.connect('mongodb://localhost:27017/simpledb');

const ItemSchema = new mongoose.Schema({
    name: String
});

const Item = mongoose.model('Item', ItemSchema);

app.post('/items', async (req, res) => {
    const newItem = new Item(req.body);
    await newItem.save();
    res.status(201).send(newItem);
});

app.get('/items', async (req, res) => {
    const items = await Item.find();
    res.status(200).send(items);
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
