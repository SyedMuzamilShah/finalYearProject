// Import 
import { connectDatabase } from './src/db/db.js';
import { app } from './app.js';

const runMain = async () => {
    try {

        // initialize the database connection
        await connectDatabase();

        const port = process.env.PORT || 8000;
        
        app.listen(port, () => {
            console.log(`⚙️ Server is running at port: ${port}`);
        });
    } catch (error) {
        console.error(error.message);
        process.exit(1);
    }
};

runMain();