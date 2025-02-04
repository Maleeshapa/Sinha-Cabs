const Guarantor = require('../model/Guarantor');
const { Op } = require('sequelize');

const createGuarantor = async (req, res) => {
    try {
        const { name, phone, address, nic, jobPosition, customerReview, customerDescription } = req.body;
        const newGuarantor = new Guarantor({
            name,
            phone,
            address,
            nic,
            jobPosition,
            customerReview,
            customerDescription
        });

        await newGuarantor.save();
        res.status(201).json({ message: 'New Guarantor created successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

const getGurantorById = async (req, res) => {
    try {
        const { id } = req.params;
        const guarantor = await Guarantor.findByPk(id);
        if (guarantor) {
            res.status(200).json(guarantor);
        } else {
            res.status(404).json({ message: 'Guarantor not found' });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

const getAllGuarantors = async (req, res) => {
    try {
        const guarantors = await Guarantor.findAll();
        res.status(200).json(guarantors);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

const getGurantorSuggestions = async (req, res) => {
    try {
        const { name } = req.params;
        const guarantors = await Guarantor.findAll({
            where: {
                guarantorName: {
                    [Op.like]: name + '%'
                }
            }
        });
        res.status(200).json(guarantors);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

module.exports = {
    createGuarantor,
    getGurantorById,
    getAllGuarantors,
    getGurantorSuggestions
}