import NodeGeocoder from "node-geocoder";

const options = {
    provider: 'opencage', // Ensure provider name is in lowercase
    apiKey: '80801cae5f894ac58cd39422b4699069', // Replace with a valid API key
    formatter: null // 'gpx', 'string', etc., or null
};

// Create an instance of the geocoder
const geocoder = NodeGeocoder(options);

export const decodeAddress = async (address) => {
    try {
        // console.log(address)
        const res = await geocoder.geocode(address);
        // console.log(res);
        return res;
    } catch (error) {
        console.error("Geocoding Error:", error.message);
        throw Error(error);
    }
};

// Test the function
// decodeAddress('Pir Abdul Khair Road, Quetta');
// [
    //     {
        //       latitude: 30.199,
        //       longitude: 67.00971,
        //       country: 'Pakistan',
        //       city: undefined,
        //       state: 'Balochistān',
        //       zipcode: undefined,
        //       streetName: undefined,
        //       streetNumber: undefined,
        //       countryCode: 'pk',
        //       county: undefined,
        //       extra: { confidence: 7, confidenceKM: 5 },
        //       provider: 'opencage'
        //     }
        //   ]


// decodeAddress('123 Main Street, City, Country');