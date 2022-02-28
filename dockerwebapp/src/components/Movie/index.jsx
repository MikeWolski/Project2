import { Card, CardHeader } from "@mui/material";

export const Movie = ({children, header}) => {
    return (
        <Card>
            <CardHeader title={header} />
        </Card>
    );
}