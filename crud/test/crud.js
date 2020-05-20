const Crud = artifacts.require('Crud');

contract('Crud', () => {
    let crud = null;
    before(async() => {
        crud = await Crud.deployed();
    });

    it('Should create a new user', async() => {
        await crud.create('John');
        const user = await crud.read(1);
        assert(user[0].toNumber() == 1);
        assert(user[1] === 'John');
    });

    it('Should update existing user', async() => {
        await crud.update(1, 'Jonathan');
        const user = await crud.read(1);
        assert(user[0].toNumber() == 1);
        assert(user[1] === 'Jonathan');
    });

    it('Should not update if user does not exist', async() => {
        try {
            await crud.update(2, 'Jonathan');
        } catch(e) {
            assert(e.message.includes('User with that id does not exist'));
            return;
        }
        assert(false);
    });

    it('Should delete user with given id', async() => {
        await crud.destroy(1);
        try {
            await crud.read(1);
        } catch(e) {
            assert(e.message.includes('User with that id does not exist'));
            return;
        }
        assert(false);
    });

    it('Should not delete user that does not exist', async() => {
        try {
            await crud.destroy(5);
        } catch(e) {
            assert(e.message.includes('User with that id does not exist'));
            return;
        }
    });
});
