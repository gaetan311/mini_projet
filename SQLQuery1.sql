USE Mini_projet;
GO

-- 1. Nettoyage complet
DROP TABLE IF EXISTS dbo.COMMANDES;
DROP TABLE IF EXISTS dbo.PRODUITS;
DROP TABLE IF EXISTS dbo.CLIENTS;
GO

-- 2. Création des structures
CREATE TABLE dbo.CLIENTS (
    ClientID INT PRIMARY KEY IDENTITY(1,1),
    Noms NVARCHAR(40),
    Villes NVARCHAR(20)
);

CREATE TABLE dbo.PRODUITS (
    ProduitID INT PRIMARY KEY IDENTITY(1,1),
    NomProduit NVARCHAR(30),
    Prix DECIMAL(10,2),
    Stock INT
);

CREATE TABLE dbo.COMMANDES (
    CommandeID INT PRIMARY KEY IDENTITY(1,1),
    ClientID INT FOREIGN KEY REFERENCES dbo.CLIENTS(ClientID),
    ProduitID INT FOREIGN KEY REFERENCES dbo.PRODUITS(ProduitID),
    Quantite INT,
    DateCommande DATE DEFAULT GETDATE()
);
GO

-- 3. Insertion après validation des structures
INSERT INTO dbo.CLIENTS (Noms, Villes) VALUES 
('Alice', 'Paris'), ('Martin', 'Marseille'), ('Joseph', 'Lyon');

INSERT INTO dbo.PRODUITS (NomProduit, Prix, Stock) VALUES 
('Ordinateur', 899.99, 2), ('Réfrigérateur', 159.99, 2), ('Scooter', 399.99, 1);

INSERT INTO dbo.COMMANDES (ClientID, ProduitID, Quantite, DateCommande) VALUES 
(1, 1, 2, '2026-07-03'), (2, 2, 1, '2026-08-09'), (1, 3, 5, '2026-07-13');
GO

-- 4. Requête finale
SELECT 
    cl.Noms AS NomClient,
    pr.NomProduit,
    co.Quantite,
    (co.Quantite * pr.Prix) AS MontantTotalPaye
FROM dbo.COMMANDES co
INNER JOIN dbo.CLIENTS cl ON co.ClientID = cl.ClientID
INNER JOIN dbo.PRODUITS pr ON co.ProduitID = pr.ProduitID;
GO
