const mysql = require('mysql2/promise');

async function test() {
  const connection = await mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'gym_new_db'
  });

  const [trainers] = await connection.execute('SELECT id, fullName, roleId, adminId FROM user WHERE roleId IN (5, 6)'); // assuming 5=PT, 6=GT or something
  console.log("Trainers:", trainers);

  if (trainers.length > 0) {
    const adminId = trainers[0].adminId;
    const [members] = await connection.execute('SELECT id, fullName, adminId FROM member WHERE adminId = ?', [adminId]);
    console.log(`Members for adminId ${adminId}:`, members.length);
  }

  await connection.end();
}

test().catch(console.error);
