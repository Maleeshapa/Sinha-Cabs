const Guarantor = require('../model/Guarantor');
const { Op } = require('sequelize');

const createGuarantor = async (req, res) => {
    try {
        const { guarantorName, guarantorNic, guarantorPhone, guarantorAddress } = req.body;
        const newGuarantor = await Guarantor.create({
            guarantorName,
            guarantorNic,
            guarantorPhone,
            guarantorAddress
        });
        res.status(201).json(newGuarantor);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

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
};

const getAllGuarantors = async (req, res) => {
    try {
        const guarantors = await Guarantor.findAll();
        res.status(200).json(guarantors);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

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
};

const updateGuarantor = async (req, res) => {
    try {
        const { id } = req.params;
        const { guarantorName, guarantorNic, guarantorPhone, guarantorAddress } = req.body;
        const guarantor = await Guarantor.findByPk(id);
        if (guarantor) {
            guarantor.guarantorName = guarantorName;
            guarantor.guarantorNic = guarantorNic;
            guarantor.guarantorPhone = guarantorPhone;
            guarantor.guarantorAddress = guarantorAddress;
            await guarantor.save();
            res.status(200).json(guarantor);
        } else {
            res.status(404).json({ message: 'Guarantor not found' });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

const deleteGuarantor = async (req, res) => {
    try {
        const { id } = req.params;
        const guarantor = await Guarantor.findByPk(id);
        if (guarantor) {
            await guarantor.destroy();
            res.status(200).json({ message: 'Guarantor deleted successfully' });
        } else {
            res.status(404).json({ message: 'Guarantor not found' });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

async function getGurantorNICsuggestions(req, res) {
    try {
        const { query } = req.params;
        
        const guarantors = await Guarantor.findAll({
            where: {
                guarantorNic: {  // Changed to match model field name
                    [Op.like]: `%${query}%`
                }
            },
            limit: 10
        });

        res.status(200).json(guarantors);
    } catch (error) {
        console.error('Error fetching guarantor suggestions:', error);
        res.status(500).json({ error: error.message });
    }
}

module.exports = {
    createGuarantor,
    getGurantorById,
    getAllGuarantors,
    getGurantorSuggestions,
    updateGuarantor,
    deleteGuarantor,
    getGurantorNICsuggestions
};