#fronted
import React, { useState, useEffect } from 'react';
import axios from 'axios';

// Display Inventory Component
function Display_Inventory() {

    const [inventory, setInventory] = useState([]);

    const resp = async () => {
        const response = await axios.get("http://localhost:8000");
        setInventory(response.data);
    };

    useEffect(() => {
        resp();
    }, []);

    return (
        <div>
            <h1>Inventory Management</h1>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                </thead>

                <tbody>
                    {inventory.map(item => (
                        <tr key={item.id}>
                            <td>{item.id}</td>
                            <td>{item.prodname}</td>
                            <td>{item.qty}</td>
                            <td>{item.price}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}


// Add Inventory Component
function AddInventory() {

    const [id, setId] = useState(0);
    const [name, setName] = useState("");
    const [qty, setQty] = useState(0);
    const [price, setPrice] = useState(0);

    const submitEvent = async (e) => {
        e.preventDefault();

        const f = { id, prodname: name, qty, price };

        await axios.post("http://localhost:8000/add", f);

        window.location.reload();
    };

    return (
        <div>
            <h1>Add Inventory</h1>

            <table>
                <tbody>
                    <tr>
                        <td>ID</td>
                        <td>
                            <input type="number" value={id}
                                onChange={e => setId(e.target.value)} />
                        </td>
                    </tr>

                    <tr>
                        <td>Name</td>
                        <td>
                            <input value={name}
                                onChange={e => setName(e.target.value)} />
                        </td>
                    </tr>

                    <tr>
                        <td>Quantity</td>
                        <td>
                            <input type="number" value={qty}
                                onChange={e => setQty(e.target.value)} />
                        </td>
                    </tr>

                    <tr>
                        <td>Price</td>
                        <td>
                            <input type="number" value={price}
                                onChange={e => setPrice(e.target.value)} />
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <button onClick={submitEvent}>
                                Submit
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
}


// Main Component
function Inventory() {
    return (
        <div>
            <Display_Inventory />
            <AddInventory />
        </div>
    );
}

export default Inventory;

#backend
const express = require('express');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json());

// Initial inventory
const inventory = [
    { id: 1, prodname: "prod1", qty: 12, price: 12 },
    { id: 2, prodname: "prod2", qty: 1, price: 13 },
    { id: 3, prodname: "prod3", qty: 10, price: 14 },
    { id: 4, prodname: "prod4", qty: 19, price: 16 }
];

// GET request
app.get('/', (req, res) => {
    res.json(inventory);
});

// POST request
app.post('/add', (req, res) => {

    const invent = {
        id: req.body.id,
        prodname: req.body.prodname,
        qty: req.body.qty,
        price: req.body.price
    };

    inventory.push(invent);

    res.json(inventory);
});

// Start server
app.listen(8000, () => {
    console.log("Express is working at http://localhost:8000");
});
